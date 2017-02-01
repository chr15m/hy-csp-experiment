(import [csp [channel c-pull c-push]]
        [time [sleep]]
        [random [randint]])

(require [csp [spawn]]
         [hy.contrib.loop [loop]])

(let [c (spawn
          (loop [[i 5]]
            (if i
              (do
                (print i)
                (if (= i 3)
                  (c-push c "half way"))
                (sleep 1)
                (recur (dec i)))
              "goodbye")))]

  (loop []
    (let [v (c-pull c)]
      (if v
        (do
          (print "got:" v)
          (recur))
        (print "done")))))
