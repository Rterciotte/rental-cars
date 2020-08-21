class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end
  
  def new
    @subsidiary = Subsidiary.new
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def create
    subsidiary_params = params.require(:subsidiary).permit(:name, :cnpj, :address)
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary, notice: 'Filial criada com sucesso!'
    else
      render :new
    end 
  
    private 
    
    def subsidiary_params 
      params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end