########################################################################################################################
#!!
#! @description: This method posts a message to a public channel, private channel, or direct message/IM channel.
#!
#! @input token: Authentication token bearing required scopes. Can be bot, workspace or user based token.
#! @input channel: Channel, private group, or IM channel to send message to. Can be an encoded ID, or a name.
#! @input text: Text of the message to send.
#!              This field is usually required, unless you're providing only attachments instead.
#! @input attachments: A JSON-based array of structured attachments, presented as a URL-encoded string.
#!                     Optional
#! @input proxy_host: Proxy server used to access the web site.
#!                    Optional
#! @input proxy_port: Proxy server port.
#!                    Default: '8080'
#!                    Optional
#! @input proxy_username: User name used when connecting to the proxy.
#!                        Optional
#! @input proxy_password: Proxy server password associated with the <proxy_username> input value.
#!                        Optional
#! @input trust_keystore: The pathname of the Java TrustStore file. This contains certificates from
#!                        other parties that you expect to communicate with, or from Certificate Authorities that
#!                        you trust to identify other parties.  If the protocol (specified by the 'url') is not
#!                        'https' or if trust_all_roots is 'true' this input is ignored.
#!                        Format: Java KeyStore (JKS)
#!                        Optional
#! @input trust_password: The password associated with the trust_keystore file. If trust_all_roots is false
#!                        and trust_keystore is empty, trust_password default will be supplied.
#!                        Optional
#! @input keystore: The pathname of the Java KeyStore file.
#!                  You only need this if the server requires client authentication.
#!                  If the protocol (specified by the 'url') is not 'https' or if trust_all_roots is 'true'
#!                  this input is ignored.
#!                  Format: Java KeyStore (JKS)
#!                  Optional
#! @input keystore_password: The password associated with the KeyStore file. If trust_all_roots is false and
#!                           keystore is empty, keystore_password default will be supplied.
#!                           Optional
#! @input connect_timeout: Time in seconds to wait for a connection to be established.
#!                         Default: '0' (infinite)
#!                         Optional
#! @input socket_timeout: Time in seconds to wait for data to be retrieved.
#!                        Default: '0' (infinite)
#!                        Optional
#!
#! @output return_result: The response of the operation in case of success or the error message otherwise.
#! @output error_message: return_result if status_code different than '200'.
#!
#! @result FAILURE: Failure occurred during execution.
#! @result SUCCESS: Operation completed successfully.
#!!#
########################################################################################################################
namespace: io.cloudslang.demos.slack.chat
imports:
  http: io.cloudslang.base.http
flow:
  name: post_message
  inputs:
    - token:
        default: "${get_sp('slack.token')}"
        sensitive: false
    - channel: "${get_sp('slack.channel')}"
    - text
    - attachments:
        required: false
    - proxy_host:
        required: false
    - proxy_port:
        required: false
    - proxy_username:
        required: false
    - proxy_password:
        required: false
    - trust_keystore:
        required: false
    - trust_password:
        required: false
    - keystore:
        required: false
    - keystore_password:
        required: false
    - connect_timeout:
        default: '0'
        required: false
    - socket_timeout:
        default: '0'
        required: false
  workflow:
    - trigger_post:
        do:
          http.http_client_post:
            - url: 'https://slack.com/api/chat.postMessage'
            - proxy_host: '${proxy_host}'
            - proxy_port: '${proxy_port}'
            - proxy_username: '${proxy_username}'
            - proxy_password:
                value: '${proxy_password}'
                sensitive: true
            - trust_keystore
            - trust_password
            - keystore
            - keystore_password
            - connect_timeout
            - socket_timeout
            - headers: "${'authorization: Bearer ' + token}"
            - attachments: "${attachments if attachments else '[]'}"
            - body: "${'{\"channel\": \"' + channel + '\",\"text\": \"' + text + '\",\"attachments\": ' + attachments + '}'}"
            - content_type: application/json
        publish:
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result
    - error_message
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      trigger_post:
        x: 100
        'y': 150
        navigate:
          57d4af2b-619b-23dd-0fb2-e4e8785b30c6:
            targetId: 9ad4963d-33f9-a8fa-e6ed-f64f67aeab75
            port: SUCCESS
    results:
      SUCCESS:
        9ad4963d-33f9-a8fa-e6ed-f64f67aeab75:
          x: 400
          'y': 150
