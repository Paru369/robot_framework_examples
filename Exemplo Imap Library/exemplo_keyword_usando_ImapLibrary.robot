----> Fiz uns ajustes no código fonte da library, então usei ela customizada no projeto:

*** Settings ***
Library     CustomImapLibrary.py



Confere envio de e-mail de alerta de saldo
  Open Mailbox      host=${IMAP.host}   port=${IMAP.port}   user=${IMAP.user}   password=${IMAP.password}
  ${EMAIL_INDEX}    Wait For Email     sender=blablablabla@gmail.com   status=UNSEEN   timeout=30
  ${BODY}           Get Email Body        ${EMAIL_INDEX}
  Delete Email      ${EMAIL_INDEX}
  ${BODY}           Decode Email Body   ${BODY}
  Should Contain    ${BODY}    Cliente: Cliente Teste - Consultas Utilizadas: 1
  Close Mailbox
 
  
---> tinha a keyword de limpar a caixa no setup do teste:

Limpar Email
  Open Mailbox                      host=${IMAP.host}   port=${IMAP.port}   user=${IMAP.user}   password=${IMAP.password}
  Delete All Emails
  Close Mailbox  