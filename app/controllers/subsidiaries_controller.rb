class SubsidiariesController < ApplicationController
    def index        
        @subsidiaries = Subsidiary.all
    end

    def show
        render :file => 'subsidiaries/show.html'
        @subsidiary = Subsidiary.find(params[:id])
    end
end