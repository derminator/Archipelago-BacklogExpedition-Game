# Kubernetes deployment examples

These reusable samples are not an export of a running cluster. They contain no cluster-specific routing, node placement, storage identifiers, or operational verification records.

The container builds upstream v3.0.0 from release commit `31d760d320ed0bb0c9bb63200dd51444ef1ed368`, runs as UID/GID 1000 on port 8080, and supports manual image publishing through `.github/workflows/container.yml` on `container/v3.0.0`.

## Customize before use

- Replace `example.invalid/backlog-expedition:v3.0.0` with your published image, preferably pinned to a verified digest.
- Select your own kubeconfig context and namespace explicitly; these manifests do not select either.
- Change `bex.example.com` and configure your ingress class and TLS. No DNS-provider or tunnel annotations are included.
- Review resource limits and probes. The Service uses an automatically assigned cluster address.

Apply the Deployment and Service to your chosen namespace. Apply the optional Ingress only after configuring routing. Check rollout status and application responses yourself; these examples make no claim about a live deployment.

The Deployment uses one replica with Recreate strategy, a non-root security context, read-only root filesystem, dropped capabilities, no service-account token, and ephemeral `emptyDir` volumes for `/mnt/data-protection` and `/tmp`. Keys disappear on Pod replacement; in-memory game sessions disappear on restart. No persistent volume is provisioned. Compose also uses ephemeral tmpfs mounts.

Keep private deployment overrides, infrastructure identifiers, and operational evidence outside this public repository. Do not commit raw cluster resource exports.
