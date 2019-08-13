namespace: io.cloudslang.demos.security.vault
flow:
  name: delete_secret
  inputs:
    - secret: "'UZ9H!N9andrei'"
  workflow:
    - url_encoder:
        do:
          io.cloudslang.base.http.url_encoder:
            - data: '${secret}'
        publish:
          - secret: '${result}'
        navigate:
          - SUCCESS: delete_secret
          - FAILURE: on_failure
    - delete_secret:
        do:
          io.cloudslang.hashicorp.vault.secrets.delete_secret:
            - hostname: "${get_sp('vault.hostname')}"
            - port: "${get_sp('vault.port')}"
            - protocol: http
            - x_vault_token:
                value: "${get_sp('vault.token')}"
                sensitive: true
            - secret: '${secret}'
            - proxy_host: "${get_sp('vault.proxy')}"
            - trust_keystore: "${get_sp('vault.truststore')}"
            - trust_password: changeit
        publish:
          - return_result
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      url_encoder:
        x: 95
        y: 386
      delete_secret:
        x: 90
        y: 146
        navigate:
          0132289a-aa86-6504-3d92-567ec2b5fc05:
            targetId: 418c631a-8e7f-4e1c-4ecb-4c2ec4430c45
            port: SUCCESS
    results:
      SUCCESS:
        418c631a-8e7f-4e1c-4ecb-4c2ec4430c45:
          x: 258
          y: 136
