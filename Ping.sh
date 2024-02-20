- name: Ping Servers
  hosts: ALL
  become: yes

  tasks:
  - name: Task ping
    ping:
    
