require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Curitiba', CNPJ: '77.187.289/0003-24', 
                        Address: 'Rua Clara, 234 - Vila das Orquídeas')
    Subsidiary.create!(name: 'São Paulo', CNPJ: '56.167.312/0003-27', 
                        Address: 'Rua Escura, 1002 - Vila Catopeblas')

    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Curitiba')
    expect(page).to have_content('São Paulo')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Curitiba', CNPJ: '77.187.289/0003-24', 
                        Address: 'Rua Clara, 234 - Vila das Orquídeas')
    Subsidiary.create!(name: 'São Paulo', CNPJ: '56.167.312/0003-27', 
                        Address: 'Rua Escura, 1002 - Vila Catopeblas')

    visit root_path
    click_on 'Filiais'
    click_on 'Curitiba'

    expect(page).to have_content('Curitiba')
    expect(page).to have_content('77.187.289/0003-24')
    expect(page).to have_content('Rua Clara, 234 - Vila das Orquídeas')
    expect(page).not_to have_content('São Paulo')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Curitiba', CNPJ: '77.187.289/0003-24', 
                        Address: 'Rua Clara, 234 - Vila das Orquídeas')
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Curitiba', CNPJ: '77.187.289/0003-24', 
                        Address: 'Rua Clara, 234 - Vila das Orquídeas')

    visit root_path
    click_on 'Filiais'
    click_on 'Curitiba'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
