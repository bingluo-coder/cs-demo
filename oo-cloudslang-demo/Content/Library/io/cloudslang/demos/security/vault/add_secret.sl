namespace: io.cloudslang.demos.security.vault
flow:
  name: add_secret
  inputs:
    - secret: maze
    - secret_value: test
  workflow:
    - get_seal_status:
        do:
          io.cloudslang.hashicorp.vault.seal_unseal.get_seal_status:
            - hostname: "${get_sp('vault.hostname')}"
            - port: "${get_sp('vault.port')}"
            - protocol: http
            - proxy_host: "${get_sp('vault.proxy')}"
            - trust_keystore: "${get_sp('vault.truststore')}"
            - trust_password: changeit
        publish:
          - sealed
        navigate:
          - SUCCESS: is_true
          - FAILURE: on_failure
    - unseal_vault_now:
        do:
          io.cloudslang.hashicorp.vault.seal_unseal.unseal_vault_now:
            - hostname: "${get_sp('vault.hostname')}"
            - port: "${get_sp('vault.port')}"
            - protocol: http
            - x_vault_token:
                value: "${get_sp('vault.token')}"
                sensitive: true
            - keys:
                value: "${get_sp('vault.keys')}"
                sensitive: true
            - proxy_host: "${get_sp('vault.proxy')}"
            - trust_keystore: "${get_sp('vault.truststore')}"
            - trust_password: changeit
        publish:
          - sealed
        navigate:
          - SUCCESS: write_secret
          - FAILURE: on_failure
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${sealed}'
        navigate:
          - 'TRUE': unseal_vault_now
          - 'FALSE': write_secret
    - write_secret:
        do:
          io.cloudslang.hashicorp.vault.secrets.write_secret:
            - hostname: "${get_sp('vault.hostname')}"
            - port: "${get_sp('vault.port')}"
            - protocol: http
            - x_vault_token:
                value: "${get_sp('vault.token')}"
                sensitive: true
            - secret: '${secret}'
            - secret_value:
                value: '${secret_value}'
                sensitive: true
            - trust_keystore: "${get_sp('vault.truststore')}"
            - trust_password: changeit
        publish:
          - return_result
          - response_headers
          - status_code
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_seal_status:
        x: 52
        y: 302
      unseal_vault_now:
        x: 55
        y: 111
      is_true:
        x: 256
        y: 288
      write_secret:
        x: 256
        y: 108
        navigate:
          e9ccfdc3-0ae5-6cfd-d1dd-b26b6617b801:
            targetId: 26f666d4-721b-620d-1c26-c9c2342d36d2
            port: SUCCESS
    results:
      SUCCESS:
        26f666d4-721b-620d-1c26-c9c2342d36d2:
          x: 465
          y: 110
