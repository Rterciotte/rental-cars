require 'rails_helper'

feature 'Admin register subsidiary' do
    scenario 'must be signed in' do
        visit root_path
        click_on 'Categorias'
    
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
    end
    scenario 'successfully' do
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        fill_in 'Nome', with: 'Paulista'
        fill_in 'CNPJ', with: '83.873.080/0784-93'
        fill_in 'Endereço', with: 'Av Paulista, 3000'
        click_on 'Enviar'

        expect(page).to have_content('Filial criada com sucesso!')
        expect(page).to have_content('Paulista')
        expect(page).to have_content('83.873.080/0784-93')
        expect(page).to have_content('Av Paulista, 3000')
    end
    
    scenario 'must fill in all fields' do
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        click_on 'Enviar'

        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
    end

    scenario 'cnpj must be valid' do
        user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                            password: '12345678')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        fill_in 'CNPJ', with: '32.435.435/0012-00'
        click_on 'Enviar'

        expect(page).to have_content('CNPJ não é válido')

    end
end