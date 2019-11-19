let types =
      ../types.dhall sha256:e48e21b807dad217a6c3e631fcaf3e950062310bfb4a8bbcecc330eb7b2f60ed

let defaults =
      ../defaults.dhall sha256:98bf62170e7785da6f627a06980c5788a5b8bdd0d1e61bb7c141beef18a3129c

let kv = (../Prelude.dhall).JSON.keyText

let spec =
      { selector =
          [ kv "app" "nginx" ]
      , type =
          Some "NodePort"
      , ports =
          [     defaults.ServicePort
            //  { targetPort = Some (types.IntOrString.Int 80), port = 80 }
          ]
      }

let service
    : types.Service
    =     defaults.Service
      //  { metadata =
                  defaults.ObjectMeta
              //  { name = "nginx", labels = [ kv "app" "nginx" ] }
          , spec =
              Some (defaults.ServiceSpec // spec)
          }

in  service