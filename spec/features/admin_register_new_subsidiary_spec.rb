require 'rails_helper'

feature 'successfully' do
    scenario 'from home index' do
       visit root_path
       click_on 'Filiais'
       click_on 'Registrar uma nova filial'
    
       fill_in 'Nome', with: 'Curitiba'
       fill_in 'CNPJ', with: '77.187.289/0003-24'
       fill_in 'Endereço', with: 'Rua Clara, 234 - Vila das Orquídeas'
       click_on 'Enviar'
    
       expect(current_path).to eq subsidiary_path(Subsidiary.last)
       expect(page).to have_content('Curitiba')
       expect(page).to have_content('77.187.289/0003-24')
       expect(page).to have_content('Rua Clara, 234 - Vila das Orquídeas')
       expect(page).to have_link('Voltar')
      end

end

feature 'Admin register valid subsidiary' do
  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Curitiba', CNPJ: '77.187.289/0003-24', Address: 'Rua Clara, 234 - Vila das Orquídeas')

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Curitiba'
    fill_in 'CNPJ', with: '77.187.289/0003-24'
    fill_in 'Endereço', with: 'Rua Clara, 234 - Vila das Orquídeas'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end