// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0;

library RegistryErrors {
    error NotHandleOwner();
    error NotTokenOwner();
    error NotHandleNorTokenOwner();
    error OnlyLensHub();
    error NotLinked();
    error DoesNotExist();
}

library HandlesErrors {
    error HandleLengthInvalid();
    error HandleContainsInvalidCharacters();
    error HandleFirstCharInvalid();
    error NotOwnerNorWhitelisted();
    error NotOwner();
    error NotHub();
    error DoesNotExist();
}
