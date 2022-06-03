def _impl(ctx):
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "k8-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "k8",
        #target_libc = "unknown",
        target_libc = "glibc-2.29",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
    )

my_cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)