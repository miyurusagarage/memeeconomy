<div class=" " style=" ">
    <h3>Your Transactions</h3>
    <p>This table show a list of investments made by you.</p>
    <hr/>
    {{ if .data}}
    <table class="col-md-12">
        <thead>
        <th class="theader" style="width: 30%;">
            Meme
        </th>
        <th class="theader" style="width: 20%;text-align: right">
            Date
        </th>
        <th class="theader" style="width: 20%;text-align: right">
            Amount
        </th>
        <th class="theader" style="width: 20%;text-align: right">
            Payout Date
        </th>
        <th class="theader" style="width: 20%;text-align: right">
            Earnings
        </th>
        </thead>

        {{ range $mm := .data}}
        <tr name="transaction-row">
            <td><a href="/getmemesingle?memeid={{$mm.MemeId}}">{{$mm.MemeName}}</a></td>
            <td style="text-align: right">{{$mm.GetCreatedTime}}</td>
            <td style="text-align: right">{{$mm.BidAmount}}</td>
            <td style="text-align: right">{{$mm.GetPayOutDate}}</td>
            <td style="text-align: right" name="payout-cell">{{$mm.PayoutAmount}}</td>
        </tr>
        {{end}}

    </table>
    {{end}}
    <div class="row ">
        <div class="text-center" style="margin: auto;">
            {{if gt .paginator.PageNums 1}}
            <ul class="pagination pagination-sm">
                {{if .paginator.HasPrev}}
                <li><a href="{{.paginator.PageLinkFirst}}" class="page-link">Prev</a></li>
                <li class="page-item"><a class="page-link" href="{{.paginator.PageLinkPrev}}">&lt;</a></li>
                {{else}}
                <li class="disabled page-item"><a class="page-link">First</a></li>
                <li class="disabled page-item"><a class="page-link">&lt;</a></li>
                {{end}}
                {{range $index, $page := .paginator.Pages}}
                <li
                        {{if $.paginator.IsActive .}} class="active page-item" {{else}} class="page-item" {{end}}>
                    <a class="page-link" href="{{$.paginator.PageLink $page}}">{{$page}}</a>
                </li>
                {{end}}
                {{if .paginator.HasNext}}
                <li class="page-item"><a class="page-link" href="{{.paginator.PageLinkNext}}">&gt;</a></li>
                <li class="page-item"><a class="page-link" href="{{.paginator.PageLinkLast}}">Next</a></li>
                {{else}}
                <li class="page-item disabled"><a class="page-link">&gt;</a></li>
                <li class="page-item disabled" class="page-link"><a>Last</a></li>
                {{end}}
            </ul>
            {{end}}
        </div>
    </div>
    {{if not .user.TransactionTipsShown }}
    <script>
        $(document).ready(function (e) {
            var tour = {
                id: "yo",
                steps: [
                    {
                        title: "Investments",
                        content: "This is your first investment.",
                        target:  document.getElementsByName("transaction-row")[0],
                        placement: "bottom"
                    },
                    {
                        title: "Payments",
                        content: "You will receive the payment when the meme expires (2 days).",
                        target: document.getElementsByName("payout-cell")[0],
                        placement: "right"
                    },
                ]
            };

            // Start the tour!
            hopscotch.startTour(tour);
        })
    </script>
    {{end}}
</div>

