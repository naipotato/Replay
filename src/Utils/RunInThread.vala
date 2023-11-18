/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[CCode (scope = "async")]
delegate T Rpy.Utils.ThreadFunc<T> () throws Error;

namespace Rpy.Utils {
    async T run_in_thread<T> (owned ThreadFunc<T> func) throws Error {
        T      result = null;
        Error? error = null;

        Worker.thread_pool.add(new Worker (() => {
            try {
                result = func ();
            } catch (Error err) {
                error = err;
            }

            Idle.add (run_in_thread.callback);
        }));

        yield;

        if (error != null)
            throw error;

        return result;
    }
}

[Compact (opaque = true)]
class Rpy.Utils.Worker {
    private static Once<ThreadPool<Worker>> _thread_pool;

    public static ThreadPool<Worker> thread_pool {
        get {
            return Worker._thread_pool.once (() => {
                var num_threads = (int) get_num_processors ();

                try {
                    return new ThreadPool<Worker>.with_owned_data ((worker) => worker.run (), num_threads, false);
                } catch (Error err) {
                    error (@"Failed to create a thread pool: $(err.message)");
                }
            });
        }
    }

    public delegate void WorkerFunc ();
    public WorkerFunc run { get; private owned set; }

    public Worker (owned WorkerFunc func) {
        this.run = (owned) func;
    }
}
