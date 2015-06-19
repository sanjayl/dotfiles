{:user 
 {:plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.10"]
                 [im.chit/vinyasa "0.3.4"]
                 [leiningen #=(leiningen.core.main/leiningen-version)]]

  :injections [(require '[vinyasa.inject :as inject])
               (inject/in [vinyasa.inject :refer [inject [in inject-in]]] ;; . ns
                          [vinyasa.lein :exclude [*project*]]
                          [vinyasa.pull :all]
                          [cemerick.pomegranate add-classpath get-classpath resources]

                          clojure.core
                          [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]
                          
                          clojure.core >
                          [clojure.pprint pprint]
                          [clojure.java.shell sh])]}}
