namespace: io.cloudslang.demos.security.vault
flow:
  name: read_secret
  inputs:
    - secret: maze
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
          - SUCCESS: read_secret
          - FAILURE: on_failure
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${sealed}'
        navigate:
          - 'TRUE': unseal_vault_now
          - 'FALSE': read_secret
    - read_secret:
        do:
          io.cloudslang.hashicorp.vault.secrets.read_secret:
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
          - secret_value
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - secret_value: '${secret_value}'
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
        x: 288
        y: 312
      read_secret:
        x: 313
        y: 111
        navigate:
          6f5c1597-8ab9-1ed3-b341-3ee5b3646e24:
            targetId: 26f666d4-721b-620d-1c26-c9c2342d36d2
            port: SUCCESS
    results:
      SUCCESS:
        26f666d4-721b-620d-1c26-c9c2342d36d2:
          x: 535
          y: 113
