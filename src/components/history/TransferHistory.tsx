import { computeFileSize } from "@/utils";

import {
  ArrowDownCircleIcon,
  ArrowUpCircleIcon,
} from "@heroicons/react/24/outline";
import { TransferHistory } from "tauri/bindings/TransferHistory";


// the required data to render the file card component
// the data will be passed dynamically

enum FileTransferType {
  SENT = "sent",
  RECEIVED = "received",
}

interface Props extends TransferHistory {}
// the component
export function FileTransferHistory({
  fileName,
  fileSize,
  transactionType,
  date,
  recipient,
  id,
}: Props) {
  return (
    <div className="flex my-4  sm:my-6 md:my-8 flex-wrap bg-[#f9fbfe]  border-gray-900  md:p-3 sm:p-3 p-2 shadow-gray-300 cursor-pointer rounded-lg hover:shadow-sm hover:shadow-gray-400 transition-shadow ease-in-out">
      <div className="pr-[10px] rounded-full"></div>
      <div className="flex flex-col text-ellipsis">
        <h5
          className="font-medium text-gray-500 truncate overflow-clip text-ellipsis"
          style={{ width: "180px" }}
        >
          {fileName}{" "}
        </h5>
        <div
          className="flex gap-3 mt[1.5px] text-gray-400  italic text-xs height={30} 
                width={30} "
        >
          <span>{computeFileSize(Number(fileSize))}</span>{" "}
          <span>{`  ${recipient}`}</span>
          <span style={{ fontSize: "" }} className="ml-2">
            {date}
          </span>
        </div>
      </div>

      <div className="hidden lg:block ml-4">
        {transactionType == FileTransferType.SENT ? (
          <ArrowUpCircleIcon className="w-8 h-8 text-gray-400 " />
        ) : (
          <ArrowDownCircleIcon className="w-8 h-8 text-gray-400 " />
        )}
      </div>
    </div>
  );
}
