*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections


*** Variables ***
${GITHUB_HOST}      https://api.github.com
${ISSUES_URI}       /repos/mayribeirofernandes/myudemyrobotframeworkcourse/issues
${MY_GITHUB_TOKEN}     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

*** Test Cases ***
Cadastrar comentário issue "12"
    Conectar com autenticação por token
    Cadastrar comentário na ISSUE#12
Consultar comentários
    Conectar na API sem autenticar
    Ver comentarios da ISSUE por "updated" e "desc"

*** Keywords ***
Conectar com autenticação por token
    ${HEADERS}          Create Dictionary    Authorization=Bearer ${MY_GITHUB_TOKEN}
    Create Session      alias=mygithubAuth   url=${GITHUB_HOST}     headers=${HEADERS}     disable_warnings=True

Conectar na API sem autenticar
    Create Session      alias=mygithub        url=${GITHUB_HOST}     disable_warnings=True

Cadastrar comentário na ISSUE#12
    ${MY_USER_DATA}     POST On Session         alias=mygithubAuth   url=${ISSUES_URI}/12/comments
    ...                 data={"body": "Comentário cadastrado via Robot Framework!"}
    Confere sucesso na requisição   ${MY_USER_DATA}

Ver comentarios da ISSUE por "${SORT}" e "${DIRECTION}"
    &{PARAMS}           Create Dictionary    sort=${SORT}      direction=${DIRECTION}
    ${MY_ISSUES}        GET On Session          alias=mygithub    url=${ISSUES_URI}    params=${PARAMS}
    Log                 Comentários de Issues: ${MY_ISSUES.json()}
    Confere sucesso na requisição   ${MY_ISSUES}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
