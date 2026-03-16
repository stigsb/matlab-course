function H = compute_entropy(p)
% COMPUTE_ENTROPY  Compute Shannon entropy in bits.
%
%   H = compute_entropy(p) computes the Shannon entropy of the discrete
%   probability distribution p, measured in bits (base-2 logarithm).
%
%   Input:
%     p - Vector of probabilities. Must be non-negative and sum to ~1.
%
%   Output:
%     H - Entropy in bits. Ranges from 0 (certain outcome) to log2(N)
%         (uniform distribution over N outcomes).
%
%   The convention 0 * log2(0) = 0 is handled by filtering out zeros
%   before computation.
%
%   Examples:
%     compute_entropy([0.5, 0.5])       % Fair coin: 1.0 bits
%     compute_entropy([1, 0, 0])        % Certain outcome: 0.0 bits
%     compute_entropy([0.25 0.25 0.25 0.25])  % Fair 4-sided die: 2.0 bits

% Validate input
if any(p < 0)
    error('compute_entropy:negativeProb', ...
        'Probabilities must be non-negative.');
end

if abs(sum(p) - 1) > 1e-6
    error('compute_entropy:notNormalized', ...
        'Probabilities must sum to 1 (got %.6f).', sum(p));
end

% Compute entropy, filtering zeros to avoid 0*log2(0) = NaN
H = -sum(p(p > 0) .* log2(p(p > 0)));

end
