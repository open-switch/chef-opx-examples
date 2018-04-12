name "leaf2"
description "The configurations for leaf2"
run_list "recipe[quagga]"
override_attributes "quagga" => { "clos_node" => "leaf2" }
