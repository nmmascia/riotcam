<webcam>
    <section>
        <h1>{title}</h1>
        <span if={error !== null}>{error}</span>
        <stream
            if={stream !== null}
            video={video}
            width="700"
            height="525"
        />
        <button onclick={snapPhoto}>Take a photo!</button>
    </section>
    <images
        data={images}
    />

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