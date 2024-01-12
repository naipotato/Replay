// Copyright 2023 Nahuel Gomez https://nahuelwexd.com
// SPDX-License-Identifier: GPL-3.0-or-later

delegate T Rpy.Utils.ThreadFunc<T> () throws Error;

namespace Rpy.Utils {
    async T run_in_thread<T> (owned ThreadFunc<T> func) throws Error {
        T      result = null;
        Error? error  = null;

        Worker.register (() => {
            try {
                result = func ();
            } catch (Error err) {
                error = err;
            }

            Idle.add (run_in_thread.callback);
        });

        yield;

        if (error != null) {
            throw error;
        }

        return result;
    }
}

[Compact (opaque = true)]
class Rpy.Utils.Worker {
    private static Once<ThreadPool<Worker>> _thread_pool;

    private WorkerFunc _func;

    private Worker (owned WorkerFunc func) {
        this._func = (owned) func;
    }

    public delegate void WorkerFunc ();

    public static void register (owned WorkerFunc func) throws ThreadError {
        unowned var thread_pool = Worker.thread_pool ();
        thread_pool.add (new Worker ((owned) func));
    }

    private static unowned ThreadPool<Worker> thread_pool () {
        return Worker._thread_pool.once (() => {
            try {
                var num_threads = (int) get_num_processors ();

                return new ThreadPool<Worker>.with_owned_data (
                    (worker) => worker._func (), num_threads, false);
            } catch (Error err) {
                error (@"Failed to create a thread pool: $(err.message)");
            }
        });
    }
}
