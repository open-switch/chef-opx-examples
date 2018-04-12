name "spine2"
description "The configurations for spine2"
run_list "recipe[quagga]"
override_attributes "quagga" => { "clos_node" => "spine2" }
