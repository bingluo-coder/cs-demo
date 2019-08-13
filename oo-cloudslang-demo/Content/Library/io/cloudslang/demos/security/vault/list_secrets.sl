namespace: io.cloudslang.demos.security.vault
flow:
  name: list_secrets
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
          - SUCCESS: list_secrets
          - FAILURE: on_failure
    - list_secrets:
        do:
          io.cloudslang.hashicorp.vault.secrets.list_secrets:
            - hostname: "${get_sp('vault.hostname')}"
            - port: "${get_sp('vault.port')}"
            - protocol: http
            - x_vault_token:
                value: "${get_sp('vault.token')}"
                sensitive: true
            - proxy_host: "${get_sp('vault.proxy')}"
            - trust_keystore: "${get_sp('vault.truststore')}"
            - trust_password: changeit
        publish:
          - return_result
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${sealed}'
        navigate:
          - 'TRUE': unseal_vault_now
          - 'FALSE': list_secrets
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
      list_secrets:
        x: 262
        y: 107
        navigate:
          68736886-1b59-785a-b2f7-49196813468a:
            targetId: 26f666d4-721b-620d-1c26-c9c2342d36d2
            port: SUCCESS
      is_true:
        x: 256
        y: 288
    results:
      SUCCESS:
        26f666d4-721b-620d-1c26-c9c2342d36d2:
          x: 465
          y: 110
