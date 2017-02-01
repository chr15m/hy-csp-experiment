(import [threading [Thread Event]]
        [Queue [Queue]])

(defn channel []
  {:queue (Queue) :closed (Event)})

(defmacro spawn [expr]
  `(do
     (import [threading [Thread]])
     (let [c (channel)
           f (fn []
               (let [q (get c :queue)
                     e (get c :closed)]
                 (.put q ~expr)
                 (.set e)))
           t (Thread :target f)]
       (.start t)
       c)))

(defn c-pull [c]
  (let [q (get c :queue)
        e (get c :closed)]
    (if (and (.empty q) (.is_set e))
      None
      (.get q))))

(defn c-push [c v]
  (let [q (get c :queue)
        e (get c :closed)]
    (when (not (.is_set e))
      (.put q v))))
