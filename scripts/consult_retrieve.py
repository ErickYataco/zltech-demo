import consul

c = consul.Consul() # This will connect to the local Consul by default.

# To get the value of a specific key:
index, data = c.kv.get('my/key')

print(data)
