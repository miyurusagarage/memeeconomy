package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"github.com/nu7hatch/gouuid"
)

type Config struct {
	Key   *datastore.Key `datastore:"__key__"`
	Name  string
	Value string
}

func (this *Config) Save() (err error) {
	var id *uuid.UUID
	id, _ = uuid.NewV4()
	urlId := id.String()
	key := datastore.NameKey(this.kind(), urlId, nil)
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, key, this); err != nil {
		fmt.Println(err)
		return err
	}
	this.Key = key
	return nil
}

func (this *Config) Update() (err error) {
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, this.Key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *Config) kind() (str string) {
	return "config"
}

func GetConfigByName(name string) (objs *Config, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("config").
		Filter("Name=", name)

	var configs []Config
	_, er := shared.DatastoreClient.GetAll(ctx, q, &configs)

	if er != nil {
		return nil, er
	}

	if len(configs) > 0 {
		return &configs[0], nil
	}
	return nil, nil
}
