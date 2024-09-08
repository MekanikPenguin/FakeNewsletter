# db/seeds.rb
Article.destroy_all
Subscriber.destroy_all

Article.create([
  { title: 'Article 1', description: 'Description of article 1 Description of article 1 Description of article 1 Description of article 1 Description of article 1 Description of article 1 Description of article 1 Description of article 1 Description of article 1 v Description of article 1 Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1Description of article 1', url: 'http://example.com/article1' },
  { title: 'Article 2', description: 'Description of article 2', url: 'http://example.com/article2' },
  { title: 'Article 3', description: 'Description of article 3', url: 'http://example.com/article3' },
  { title: 'Article 4', description: 'Description of article 4', url: 'http://example.com/article4' },
  { title: 'Article 5', description: 'Description of article 5', url: 'http://example.com/article5' }
])

Subscriber.create(email: 'test@example.com')
