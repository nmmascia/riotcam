<stream>
    <video name="video" src={opts.video} autoplay="true" width="700" height="525" />
    <canvas name="canvas" width="700" height="525" />

    <script>
        this.getData = () => {
            const context = this.canvas.getContext('2d');
            context.drawImage(this.video, 0, 0, this.video.width, this.video.height);
            const url = this.canvas.toDataURL('image/png');
            return url;
        }
    </script>

    <style scoped>
        video {
            display: block;
            margin: 0 auto;
            width: 100%;
        }

        canvas {
            display: none;
        }
    </style>
</stream>

<images>
    <div class="filmstrip" name="filmstrip">
        <div
            class="thumbnail"
            each="{image in opts.data}"
            style="background-image:url({image})"
        />
    </div>
    <style scoped>
        .filmstrip {
            margin: 0 auto;
            padding: 5px 0;
            width: 700px;
        }

        .thumbnail {
            display: inline-block;
            height: 131px;
            width: 175px;
            background-position: center;
            background-repeat: no-repeat;
            background-size: contain;
        }
    </style>
</images>

<webcam>
    <section>
        <h1>{title}</h1>
        <span if={error !== null}>{error}</span>
        <stream if={stream !== null} video={video} />
        <button onclick={snapPhoto}>Take a photo!</button>
    </section>
    <images data={images} />

    <script>
        import {
            closeStream,
            createVideo,
            requestCamera,
        } from '../lib/webcam';

        this.error = null;
        this.images = [];
        this.stream = null;
        this.title = opts.title || '~~ Riotcam ~~';
        this.video = null;

        // request camera access
        requestCamera()
        .then(stream => {
            this.stream = stream;
            this.video = createVideo(stream);
            this.update();
        })
        .catch(err => {
            this.error = err;
            this.update();
        });

        // calls getData func on child tag, updates images
        this.snapPhoto = (e) => {
            const image = this.tags.stream.getData();
            this.images = [...this.images, image];
            this.update();
        }

        // close stream before unmount
        this.on('before-unmount', () => {
            closeStream(this.stream);
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

        button {
            display: block;
            padding: 10px;
            margin: 15px auto 13px;
            border-radius: 4px;
            height: 50px;
        }
    </style>
</webcam>