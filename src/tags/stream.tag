<stream>
    <video
        name="video"
        src={opts.video}
        autoplay="true"
        width={opts.width}
        height={opts.height}
    />
    <canvas
        name="canvas"
        width={opts.width}
        height={opts.height}
    />

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