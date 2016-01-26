<stream>
    <video src={opts.video} autoplay="true"></video>

    <style scoped>
        video {
            display: block;
            margin: 0 auto;
            border: 5px solid #666;
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

        this.title = 'Riotcam';
        this.error = null;
        this.stream = null;
        this.video = null;

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
            console.log(e);
        }

        // lifecycle methods

        this.on('before-unmount', () => {
            this.stream.getVideoTracks()[0].stop();
        });

    </script>

    <style scoped>
        h1 {
            font-size: 2em;
            text-align: center;
            font-family: Arial, sans-serif;
            text-transform: uppercase;
        }

        div {
            margin: 0 auto;
            height: 50px;
            width: 650px;
            background-color: #666;
        }

        button {
            display: block;
            margin: 0 auto;
            padding: 10px;
            border-radius: 4px;
        }
    </style>

</webcam>