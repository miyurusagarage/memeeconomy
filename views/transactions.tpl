<div class=" " style=" ">
    <h3>Your Transactions</h3>
    <p>This table show a list of investments made by you.</p>
    <hr/>
    {{ if .data}}
    <table class="col-md-12">
        <thead>
        <th style="width: 30%;">
            Meme
        </th>
        <th style="width: 10%;">
            Link
        </th>
        <th style="width: 20%;">
            Date
        </th>
        <th style="width: 20%;text-align: right">
            Amount
        </th>
        <th style="width: 20%;text-align: right">
            Earnings
        </th>
        </thead>

        {{ range $mm := .data}}
        <tr>
            <td>{{$mm.MemeName}}</td>
            <td><a href="/getmemesingle?memeid={{$mm.MemeId}}">link</a></td>
            <td>{{$mm.GetCreatedTime}}</td>
            <td style="text-align: right">{{$mm.BidAmount}}</td>
            <td style="text-align: right">{{$mm.PayoutAmount}}</td>
        </tr>
        {{end}}

    </table>
    {{end}}
    <div class="row text-center">
        {{if gt .paginator.PageNums 1}}
        <ul class="pagination pagination-sm">
            {{if .paginator.HasPrev}}
            <li><a href="{{.paginator.PageLinkFirst}}">Prev</a></li>
            <li><a href="{{.paginator.PageLinkPrev}}">&lt;</a></li>
            {{else}}
            <li class="disabled"><a>First</a></li>
            <li class="disabled"><a>&lt;</a></li>
            {{end}}
            {{range $index, $page := .paginator.Pages}}
            <li
                    {{if $.paginator.IsActive .}} class="active" {{end}}>
                <a href="{{$.paginator.PageLink $page}}">{{$page}}</a>
            </li>
            {{end}}
            {{if .paginator.HasNext}}
            <li><a href="{{.paginator.PageLinkNext}}">&gt;</a></li>
            <li><a href="{{.paginator.PageLinkLast}}">Next</a></li>
            {{else}}
            <li class="disabled"><a>&gt;</a></li>
            <li class="disabled"><a>Last</a></li>
            {{end}}
        </ul>
        {{end}}
    </div>
</div>

