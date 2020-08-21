require 'rails_helper'

feature 'User sign in' do

    scenario 'from home page' do
        visit root_path

        expect(page).to have_link('Entrar')
    end

    scenario 'succesfully' do
        User.create!(name: 'Rogério Terciotte', 
                    email: 'rogerio@email.com', password: '12345678')

        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'rogerio@email.com'
        fill_in 'Senha', with: '12345678'
        click_on 'Entrar'

        expect(page).to have_content 'Rogério Terciotte'
        expect(page).to have_content('Login efetuado com sucesso')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Entrar')     
    end
    
    scenario 'user signed out' do
        user = User.create!(name: 'Rogério Terciotte', 
                    email: 'rogerio@email.com', password: '12345678')
        user_login(user)                
        visit root_path
        expect(page).to have_content('Sair')
        click_on 'Sair'
        expect(page).not_to have_content 'Rogério Terciotte'
        expect(page).to have_link('Entrar')
        
    end

end