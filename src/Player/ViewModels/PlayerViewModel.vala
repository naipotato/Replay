/*
 * Copyright 2023 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.PlayerViewModel : ViewModel {
    public VideoRepository repository { get; construct;   }
    public string?         uri        { get; private set; }

    public PlayerViewModel (VideoRepository? repository = null) {
        Object (repository: repository ?? new VideoRepository ());
    }

    public async void fetch_video_details (string id) {
        this.state = IN_PROGRESS;

        try {
            var video = yield this.repository.video (id);

            this.uri = video.qualities[Quality.HD720]
                ?? video.qualities[Quality.MEDIUM]
                ?? video.qualities[Quality.SMALL];

            this.state = SUCCESS;
        } catch {
            this.state = ERROR;
        }
    }
}
