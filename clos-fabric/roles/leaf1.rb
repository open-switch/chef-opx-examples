name "leaf1"
description "The configurations for leaf1"
run_list "recipe[quagga]"
override_attributes "quagga" => { "clos_node" => "leaf1" }
