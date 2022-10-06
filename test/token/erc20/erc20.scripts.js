"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Scripts = void 0;
exports.Scripts = {
    metadata: {
        check_name: "returns the name of the token.",
        check_symbol: "returns the symbol of the token.",
        check_decimals: "returns the number of decimals the token uses.",
        check_total_supply: "returns the total token supply.",
        check_pre_mint_receiver: "returns the balance of the address that received the premint amount.",
    },
    standard: {
        check_transfer: "transfer, transfers _value amount of tokens to address _to, and MUST emit the Transfer event.",
        check_non_address_to_transfer: "prevents to of non-address to transfer.",
        check_tranferfrom: "transferFrom, transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.",
        check_non_address_to_approve: "prevents approve with _to non-address",
    },
};
