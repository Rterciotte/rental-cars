class RentalsController < ApplicationController
    before_action :authenticate_user!
    def index
        @rental = Rental.find(params[:id])
    end

    def new
        @rental = Rental.new
        @clients = Client.all
        @car_categories = CarCategories.all
    end

    def create
        @rental = Rental.new(rental_params)
        @rental.user = current_user
        @rental = save!
        redirect_to @rental, notice: 'Agendamento realizado com sucesso'                                   
    end

    private

    def rental_params 
        params.require(:rental)
        .permit(:start_date, :end_date, :client_id, :car_category_id)
    end    
end