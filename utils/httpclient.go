package utils

import (
	"net/http"
	"encoding/json"
	"time"
)

var simpleHttpClient = &http.Client{Timeout: 10 * time.Second}

func GetJson(url string, target interface{}) error {
	r, err := simpleHttpClient.Get(url)
	if err != nil {
		return err
	}
	defer r.Body.Close()

	return json.NewDecoder(r.Body).Decode(target)
}
