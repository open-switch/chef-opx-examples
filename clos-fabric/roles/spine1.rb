name "spine1"
description "The configurations for spine1"
run_list "recipe[quagga]"
override_attributes "quagga" => { "clos_node" => "spine1" }
