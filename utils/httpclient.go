package utils

import (
	"net/http"
	"encoding/json"
	"time"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
)

var simpleHttpClient = &http.Client{Timeout: 10 * time.Second}


//use this for decoding json from fb, it will load the custom fb error upon failure
func GetFbJson(url string, target shared.FbUser) *shared.FbError {
	r, err := simpleHttpClient.Get(url)

	if err != nil {
		return nil
	}
	defer r.Body.Close()

	if (r.StatusCode != 200) {
		fbErrorObj := new(shared.FbError)
		json.NewDecoder(r.Body).Decode( fbErrorObj)
		fmt.Println( fbErrorObj.Error.Code)
		return   fbErrorObj
	}

	json.NewDecoder(r.Body).Decode(target)

	return nil
}
