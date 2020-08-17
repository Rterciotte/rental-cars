require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Paulista', cnpj: '15.269.968/0001-95',
                       address: 'Av Paulista 10')
    Subsidiary.create!(name: 'Vila Mariana', cnpj: '58.346.316/0001-10',
                       address: 'Av Sena Madureira, 50')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Paulista')
    expect(page).to have_content('Av Paulista 10')
    expect(page).to have_content('Vila Mariana')
    expect(page).to have_content('Av Sena Madureira, 50')
  end
end