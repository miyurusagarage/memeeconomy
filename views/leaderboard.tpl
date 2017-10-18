<div class=" " style=" ">
    <h3>Top Users</h3>
    <p>The top 100 richest folk in the meme market.</p>
    <hr/>
    {{ if .data}}

    {{ range $ind, $mm := .data}}
    <div class="row ">
        <div class="col-md-12">
            {{ if gt $ind 0}}
            <h5 style="float: left; width: 50px;">#{{$ind}}</h5>
            <h5 style="float: left"><a href="/profile?id={{$mm.Key.Name}}">{{$mm.Username}}</a></h5>

            <h5 style="float: right">{{$mm.CurrentCredit}}</h5>
            {{end}}
        </div>
    </div>
    {{end}}


    {{end}}

</div>

