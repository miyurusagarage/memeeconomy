package utils

import (

	"image/jpeg"

	"github.com/miyurusagarage/memeeconomy/shared"
	"golang.org/x/net/context"
	"image"

)

type Resolution struct {
	Width  int
	Height int
}



func uploadToGCS(m *image.NRGBA, urlId string) {
	ctx := context.Background()
	gcsObj := shared.Bkt.Object(urlId + ".jpg")
	writer := gcsObj.NewWriter(ctx)
	defer writer.Close()
	jpeg.Encode(writer, m, nil)
}
