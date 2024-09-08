require 'net/http'
require 'json'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:add_to_newsletter, :remove_from_newsletter, :destroy]

  def index
    @articles = Article.where(added_to_newsletter: false)
  end

  def add_to_newsletter
    @article.update(added_to_newsletter: true)
    redirect_to articles_path, notice: 'Article ajouté à la newsletter.'
  end

  def remove_from_newsletter
    @article.update(added_to_newsletter: false)
    redirect_to articles_path, notice: 'Article retiré de la newsletter.'
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article supprimé.'
  end

  def extract
    query = 'désinformation OR "fake news" OR "théories du complot" OR complotisme OR complotiste OR conspirationnisme OR disinformation OR "conspiracist" OR QAnon OR "fact-checking" OR "fact-checker" OR debunker OR debunkage'
    api_key = ENV['GOOGLE_API_KEY']
    custom_search_cx = ENV['GOOGLE_CUSTOM_SEARCH_CX']
    max_results = 10

    uri = URI("https://www.googleapis.com/customsearch/v1?q=#{ERB::Util.url_encode(query)}&key=#{api_key}&cx=#{custom_search_cx}&dateRestrict=d7&num=#{max_results}")

    begin
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)

      if result['items']
        result['items'].each do |item|
          next unless item['title'] && item['snippet'] && item['link']
          unless Article.exists?(url: item['link'])
            Article.create(
              title: item['title'],
              description: item['snippet'],
              url: item['link']
            )
          end
        end
        flash[:notice] = 'Extraction terminée et articles ajoutés.'
      else
        flash[:alert] = 'Aucun article trouvé ou problème avec l\'API.'
      end

    rescue StandardError => e
      Rails.logger.error("Erreur lors de l'extraction des articles: #{e.message}")
      flash[:alert] = "Erreur lors de l'extraction des articles : #{e.message}"
    end

    redirect_to articles_path
  end

  def process_articles
    api_key = ENV.fetch('CHATGPT_API_KEY', nil)

    @articles = Article.where(added_to_newsletter: false)

    @articles.each do |article|
      prompt = <<~TEXT
        Voici un article intitulé "#{article.title}".

        Résume cet article en français en mettant en avant son principal apport dans le domaine de la désinformation.
        Attribue un score de pertinence ("forte", "moyenne" ou "faible") en fonction de son importance pour suivre l'évolution du sujet.
        Enfin, classe cet article dans l'une des catégories suivantes : "Études et chiffres", "Propagande", "Nos complotistes ont du talent", "Outils", "Médias", "Réformes et institutions", "Podcasts", "Fact-Checking", "Dérives sectaires", "QAnon", "Intelligence artificielle", "Réseaux sociaux", ou "Autres".

        Résultat attendu :
        - title: "Titre de l'article"
        - description: "Résumé en français"
        - pertinence: "forte/moyenne/faible"
        - category: "La catégorie appropriée"
      TEXT

      uri = URI("https://api.openai.com/v1/chat/completions")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      })

      request.body = {
        model: "gpt-3.5-turbo",
        messages: [{ role: "system", content: "You are a helpful assistant." }, { role: "user", content: prompt }],
        max_tokens: 500
      }.to_json

      response = http.request(request)
      parsed_response = JSON.parse(response.body)

      if parsed_response['choices'] && parsed_response['choices'][0]
        chatgpt_result = parsed_response['choices'][0]['message']['description']

        # Suppose que ChatGPT renvoie une réponse bien structurée que l'on peut parser
        title, content, pertinence, category = chatgpt_result.match(/title:\s*(.*)\ndescription:\s*(.*)\npertinence:\s*(.*)\ncategory:\s*(.*)/i).captures

        # Mettre à jour l'article avec les nouvelles informations
        article.update(
          title: title.strip,
          description: content.strip,
          pertinence: pertinence.strip.downcase,
          category: category.strip.downcase
        )
      else
        Rails.logger.error("Erreur lors de la communication avec ChatGPT : #{response.body}")
      end
    end

    redirect_to articles_path, notice: 'Articles traités avec succès.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
