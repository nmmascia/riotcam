<images>
    <div class="filmstrip" name="filmstrip">
        <div
            class="thumbnail"
            each="{image in opts.data}"
            style="background-image:url({image});"
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