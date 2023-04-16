*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${CADASTRO_TITLE}           Login - My Store
${CADASTRO_BTN_EMAIL}       id=email_create
${CADASTRO_BTN_CREATE}      id=SubmitCreate
${CADASTRO_MSG_FORM}        xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
&{CADASTRO_FORM_FIELDS}     genero=id_gender2
...                         nome=customer_firstname
...                         ultimo_nome=customer_lastname
...                         senha=passwd
...                         endereco=address1
...                         cidade=city
...                         estado=id_state
...                         cep=postcode
...                         telefone=phone_mobile
${CADASTRO_BTN_SUBMIT}      submitAccount
${CADASTRO_MSG_CADASTRO}    xpath=//*[@id="center_column"]/p
${CADASTRO_USUARIO}         xpath=//*[@id="header"]/div[2]//div[1]/a/span

*** Keywords ***
#### Ações
Informar um e-mail válido
    Title Should Be                 ${CADASTRO_TITLE}
    Wait Until Element Is Visible   ${CADASTRO_BTN_EMAIL}
    ${EMAIL}                        Generate Random String
    Input Text                      ${CADASTRO_BTN_EMAIL}    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Click Button    ${CADASTRO_BTN_CREATE}

Preencher os dados obrigatórios
    Wait Until Element Is Visible   ${CADASTRO_MSG_FORM}
    Click Element                   ${CADASTRO_FORM_FIELDS.genero}
    Input Text                      ${CADASTRO_FORM_FIELDS.nome}          May
    Input Text                      ${CADASTRO_FORM_FIELDS.ultimo_nome}   Fernandes
    Input Text                      ${CADASTRO_FORM_FIELDS.senha}         123456
    Input Text                      ${CADASTRO_FORM_FIELDS.endereco}      Rua Framework, Bairro Robot
    Input Text                      ${CADASTRO_FORM_FIELDS.cidade}        Floripa
    Set Focus To Element            ${CADASTRO_FORM_FIELDS.estado}
    ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
    ### pelo elemento quando for firefox
    Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   ${CADASTRO_FORM_FIELDS.estado}
    Select From List By Index       ${CADASTRO_FORM_FIELDS.estado}        9
    Input Text                      ${CADASTRO_FORM_FIELDS.cep}           12345
    Input Text                      ${CADASTRO_FORM_FIELDS.telefone}      99988877

Submeter cadastro
    Click Button    ${CADASTRO_BTN_SUBMIT}

### Conferências
Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    ${CADASTRO_MSG_CADASTRO}
    Element Text Should Be           ${CADASTRO_MSG_CADASTRO}
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           ${CADASTRO_USUARIO}    May Fernandes
