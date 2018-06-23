# Make sure fqdn is resolvable
/etc/hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://{{ slspath }}/hosts.jinja
    - template: jinja
    - defaults:
      domain: {{ pillar['network']['domain'] }}
      hostname: {{ grains['id'] }}

# Set hostname according to minion_id
/etc/hostname:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - contents:
      - {{ grains['id'] }}
  cmd.run:
    - name: hostname -F /etc/hostname
    - onchanges:
      - file: /etc/hostname
