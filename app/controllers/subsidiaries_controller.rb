class SubsidiariesController < ApplicationController
    def index        
        @subsidiaries = Subsidiary.all
    end

    def show
        @subsidiary = Subsidiary.find(params[:id])
    end

    def new
        @subsidiary = Subsidiary.new
    end

    def create
        @subsidiary = Subsidiary.create(subsidiary_params)
        if @subsidiary.save
            redirect_to @subsidiary
        else
            render :new
        end    
    end

    private

    def subsidiary_params
        params.require(:subsidiary).permit(:name, :CNPJ, :Address)
    end
end