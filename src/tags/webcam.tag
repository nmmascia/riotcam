<stream>
    <video id="video" src={opts.video} autoplay="true"></video>
    <canvas id="canvas"></canvas>

    <script>
        this.canvas = null;
        this.context = null;

        this.on('mount', () => {
            this.canvas = document.getElementById('canvas');
            const video = document.getElementById('video');

            this.context = canvas.getContext('2d');
            this.context.drawImage(video, 0, 0);
        });

        this.getImageData = () => {
            return this.canvas.toDataURL();
        }
    </script>

    <style scoped>
        video {
            display: block;
            margin: 0 auto;
            width: 100%;
        }

        canvas {
            position: fixed;
            bottom: 0;
            right: 0;
        }
    </style>
</stream>

<webcam>
    <section>
        <h1>{title}</h1>
        <span if={error !== null}>{error}</span>
        <stream if={stream !== null} video={video}></stream>
        <div>
            <button onclick={snapPhoto}>Take a photo!</button>
        </div>
    </section>

    <script>
        import getUserMedia from 'getusermedia';

        this.title = opts.title || '~~ Riotcam ~~';
        this.error = null;
        this.stream = null;
        this.video = null;
        this.snaps = [];

        getUserMedia({ video: true }, (err, stream) => {
            if (err) {
                this.error = err.name;
            } else {
                this.stream = stream;
                this.video = URL.createObjectURL(stream);
            };
            this.update();
        });

        this.snapPhoto = (e) => {
            const image = this.tags.stream.getImageData();
            this.snaps = this.spans.push(image);
            this.update();
        }

        this.on('before-unmount', () => {
            this.stream.getVideoTracks()[0].stop();
        });
    </script>

    <style scoped>
        section {
            padding: 5px;
            width: 700px;
            background-color: #000042;
            margin: 0 auto;
            border-radius: 6px;
            font-size: 16px;
            color: #ffa4d1;
        }

        h1 {
            padding: 15px 0;
            margin: 0;
            font-size: 2em;
            text-align: center;
            font-family: Arial, sans-serif;
            text-transform: uppercase;
        }

        div {
            margin: 0 auto;
            padding-top: 15px;
            height: 50px;
            width: 100%;
        }

        button {
            display: block;
            margin: 0 auto;
            padding: 10px;
            border-radius: 4px;
        }
    </style>
</webcam>