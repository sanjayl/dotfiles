{;; :repl
 ;; {:dependencies [[im.chit/vinyasa "0.3.4"]
 ;;                 [leiningen #=(leiningen.core.main/leiningen-version)]]

 ;;  :injections   [(require '[vinyasa.inject :as inject])
 ;;                 (inject/in [clojure.pprint [pprint p]] ;; . ns
 ;;                                        ;inject function as ./inject and
 ;;                                        ;in macro as ./inject-in
 ;;                            [vinyasa.inject :refer [inject [in inject-in]]] 
 ;;                            [vinyasa.lein :exclude [*project*]]
 ;;                            [vinyasa.pull :all]
 
 ;;                            clojure.core > ;; core ns with > prefix
 ;;                            [clojure.java.shell sh]
 ;;                            [clojure.pprint [pprint >p]]
 ;;                            [clojure.pprint [pprint >P]])]}
 :cider
 {:plugins      [;;[refactor-nrepl "2.2.0-SNAPSHOT"]
                 [cider/cider-nrepl "0.12.0-SNAPSHOT"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}
