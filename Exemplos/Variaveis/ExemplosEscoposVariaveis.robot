*** Settings ***
Documentation   Exemplo de escopo de variáveis: GLOBAIS, SUITE, TESTE (test case) e LOCAL (keyword)
Library         String

*** Variable ***
${GLOBAL_INSTANCIADA}     Minha variável GLOBAL_INSTANCIADA foi instanciada para a suíte

*** Test Cases ***
Caso de teste de exemplo 01
    Uma keyword qualquer 01
    Uma keyword qualquer 02

Caso de teste de exemplo 02
    Uma keyword qualquer 02
    Uma keyword qualquer 03

Caso de teste de exemplo 03
    Uma keyword qualquer 04

*** Keywords ***
Uma keyword qualquer 01
    ${GLOBAL_CRIADA_EM_TEMPO_EXECUCAO}     Generate Random String
    #A variável "global" pode ser utilizada em todas as suítes em execução
    Set Global Variable    ${GLOBAL_CRIADA_EM_TEMPO_EXECUCAO}
    #A variável "suite" pode ser utilizada somente nos testes da suíte em execução
    Set Suite Variable     ${SUITE_CRIADA_EM_TEMPO_EXECUCAO}    Variável da suíte
    #A variável "test" pode ser utilizada somente nas todas as keywords do teste em execução
    Set Test Variable      ${TESTE_01}   Variável do teste 01
    Log         ${TESTE_01}
    #A variável "local" pode ser utilizada somente na keyword em execução
    ${LOCAL}    Set Variable    Variável local da keyword 01
    Log   ${LOCAL}

Uma keyword qualquer 02
    ${LOCAL}     Set Variable    Variável local da keyword 02
    Log    ${LOCAL}
    Log    ${GLOBAL_INSTANCIADA} / ${GLOBAL_CRIADA_EM_TEMPO_EXECUCAO} / ${SUITE_CRIADA_EM_TEMPO_EXECUCAO} / ${LOCAL}
    # A keyword abaixo vai funcionar no Caso de Teste 01 e falhar no Case de Teste 02
    Log    ${TESTE_01}

Uma keyword qualquer 03
    ${LOCAL}     Set Variable    Variável local da keyword 03
    Log    ${LOCAL}
    Log    ${GLOBAL_INSTANCIADA} / ${GLOBAL_CRIADA_EM_TEMPO_EXECUCAO} / ${SUITE_CRIADA_EM_TEMPO_EXECUCAO} / ${LOCAL}

Uma keyword qualquer 04
    ${LOCAL}     Set Variable    Variável local da keyword 04
    Log    ${LOCAL}
    Log    ${GLOBAL_INSTANCIADA} / ${GLOBAL_CRIADA_EM_TEMPO_EXECUCAO} / ${SUITE_CRIADA_EM_TEMPO_EXECUCAO} / ${LOCAL}

*** Variables ***
&{DIAS_EM_CADA_MES}      janeiro=31
...                    fevereiro=28
...                    março=31
...                    abril=30
...                    maio=31
...                    junho=30
...                    julho=31
...                    agosto=31
...                    setembro=30
...                    outubro=31
...                    novembro=30
...                    dezembro=31

*** Test Cases ***
Imprimir dias por mês de 2023
    Log To Console     Janeiro de 2023 contém  ${DIAS_EM_CADA_MES.janeiro} dias
    Log To Console     Fevereiro de 2023 contém ${DIAS_EM_CADA_MES.fevereiro} dias
    Log To Console     Março de 2023 contém ${DIAS_EM_CADA_MES.março} dias
    Log To Console     Abril de 2023 contém ${DIAS_EM_CADA_MES.abril} dias
    Log To Console     Maio de 2023 contém ${DIAS_EM_CADA_MES.maio} dias
    Log To Console     Junho de 2023 contém ${DIAS_EM_CADA_MES.junho} dias
    Log To Console     Julho de 2023 contém ${DIAS_EM_CADA_MES.julho} dias
    Log To Console     Agosto de 2023 contém ${DIAS_EM_CADA_MES.agosto} dias
    Log To Console     Setembro de 2023 contém ${DIAS_EM_CADA_MES.setembro} dias
    Log To Console     Outubro de 2023 contém ${DIAS_EM_CADA_MES.outubro} dias
    Log To Console     Novembro de 2023 contém ${DIAS_EM_CADA_MES.novembro} dias
    Log To Console     Dezembro de 2023 contém ${DIAS_EM_CADA_MES.dezembro} dias