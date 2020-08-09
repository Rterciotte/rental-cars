require 'rails-helper'

feature 'Visitor open home page' do
    scenario 'successfully' do
        #3 As --> Arrange, Act, Assert
        #Arrange
        
        # Act
        visit root_path
        
        # Assert
        expect(page).to have_css('h1', text:'Rental Cars')
        expect(page).to have_content('Bem vindo ao sistema de gestão de locação')
    end
end