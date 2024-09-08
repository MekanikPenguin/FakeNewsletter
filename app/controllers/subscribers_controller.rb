# app/controllers/subscribers_controller.rb
class SubscribersController < ApplicationController
  def index
    @subscribers = Subscriber.all # Initialisation de la variable @subscribers
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      redirect_to subscribers_path, notice: 'Email ajouté à la liste.'
    else
      redirect_to subscribers_path, alert: 'Email invalide.'
    end
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    redirect_to subscribers_path, notice: 'Email retiré de la liste.'
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
